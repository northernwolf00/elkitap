
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


class AudioPlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final RxBool isPlaying = false.obs;
  final RxDouble playbackSpeed = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initAudio();
  }

  final RxString audioSource = ''.obs;
  final RxBool isAssetAudio = true.obs; // true for asset, false for URL

  Future<void> _initAudio() async {
    try {
      if (audioSource.value.isEmpty) {
        // Default audio source - change this to your preference
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

  // Load audio from asset file
  void loadFromAsset(String assetPath) {
    loadAudio(assetPath, true);
  }

  // Load audio from URL
  void loadFromUrl(String url) {
    loadAudio(url, false);
  }

  void playPause() {
    if (isPlaying.value) {
      _audioPlayer.pause();
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
    _audioPlayer.seek(newPosition > Duration.zero ? newPosition : Duration.zero);
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
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}

