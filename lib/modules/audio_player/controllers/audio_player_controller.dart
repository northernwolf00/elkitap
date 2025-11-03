import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final RxBool isPlaying = false.obs;
  final RxDouble playbackSpeed = 1.0.obs;

  // Sleep timer properties
  final Rxn<Duration> sleepTimerDuration = Rxn<Duration>();
  final Rx<DateTime?> sleepTimerEndTime = Rx<DateTime?>(null);
  Timer? _sleepTimer;
  Timer? _countdownTimer;

  final RxBool isDriverMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initAudio();
  }

  final RxString audioSource = ''.obs;
  final RxBool isAssetAudio = true.obs;

  Future<void> _initAudio() async {
    try {
      if (audioSource.value.isEmpty) {
        audioSource.value = 'assets/audio/au2.mp3';
        isAssetAudio.value = true;
      }

      await loadAudio(audioSource.value, isAssetAudio.value);

      _audioPlayer.durationStream.listen((d) {
        if (d != null) duration.value = d;
      });

      _audioPlayer.positionStream.listen((p) {
        position.value = p;
      });

      _audioPlayer.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  Future<void> loadAudio(String source, bool isAsset) async {
    try {
      if (isAsset) {
        await _audioPlayer.setAsset(source);
      } else {
        await _audioPlayer.setUrl(source);
      }
      audioSource.value = source;
      isAssetAudio.value = isAsset;
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void loadFromAsset(String assetPath) {
    loadAudio(assetPath, true);
  }

  void loadFromUrl(String url) {
    loadAudio(url, false);
  }

  void playPause() {
    if (isPlaying.value) {
      _audioPlayer.pause();
      // isPlaying.value = false;
      // Get.find<GlobalMiniPlayerController>().hide();
    } else {
      _audioPlayer.play();
    }
  }

  void seekForward() {
    final newPosition = position.value + const Duration(seconds: 15);
    _audioPlayer.seek(newPosition);
  }

  void seekBackward() {
    final newPosition = position.value - const Duration(seconds: 15);
    _audioPlayer
        .seek(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void changeSpeed() {
    if (playbackSpeed.value == 1.0) {
      playbackSpeed.value = 1.5;
    } else if (playbackSpeed.value == 1.5) {
      playbackSpeed.value = 2.0;
    } else {
      playbackSpeed.value = 1.0;
    }
    _audioPlayer.setSpeed(playbackSpeed.value);
  }

  String formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours == 0) {
      final m = minutes.toString();
      final s = seconds.toString().padLeft(2, '0');
      return '$m:$s';
    } else {
      if (minutes > 0) {
        return '$hours hour${hours > 1 ? 's' : ''}, $minutes minute${minutes > 1 ? 's' : ''}';
      } else {
        return '$hours hour${hours > 1 ? 's' : ''}';
      }
    }
  }

  void setSpeed(double speed) {
    playbackSpeed.value = speed;
    _audioPlayer.setSpeed(speed);
  }

  // Sleep timer methods
  void setSleepTimer(Duration? duration) {
    cancelSleepTimer();

    if (duration == null) {
      sleepTimerDuration.value = null;
      sleepTimerEndTime.value = null;
      return;
    }

    sleepTimerDuration.value = duration;
    sleepTimerEndTime.value = DateTime.now().add(duration);

    _sleepTimer = Timer(duration, () {
      _audioPlayer.pause();
      sleepTimerDuration.value = null;
      sleepTimerEndTime.value = null;
      _countdownTimer?.cancel();
    });

    // Update countdown every second
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (sleepTimerEndTime.value == null) {
        timer.cancel();
      }
    });
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _countdownTimer?.cancel();
    sleepTimerDuration.value = null;
    sleepTimerEndTime.value = null;
  }

  String getRemainingTime() {
    if (sleepTimerEndTime.value == null) return '';

    final remaining = sleepTimerEndTime.value!.difference(DateTime.now());
    if (remaining.isNegative) return '0:00';

    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleDriverMode() {
    isDriverMode.value = !isDriverMode.value;
  }

  void enableDriverMode() {
    isDriverMode.value = true;
  }

  void disableDriverMode() {
    isDriverMode.value = false;
  }

  void stopAudio() {
    _audioPlayer.pause();
    // duration.value = Duration.zero;
    // position.value = Duration.zero;
    // isPlaying.value = false;
    // _audioPlayer.stop();
    isPlaying.value = false;
    Get.find<GlobalMiniPlayerController>().hide();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    cancelSleepTimer();
    super.onClose();
  }
}

class GlobalMiniPlayerController extends GetxController {
  final RxBool isVisible = false.obs;

  void show() => isVisible.value = true;
  void hide() => isVisible.value = false;
  void toggle() => isVisible.value = !isVisible.value;
}
