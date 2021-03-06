import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:microphone/microphone.dart';
import 'dart:html';

enum AudioState { recording, stop, play }

const veryDarkBlue = Color(0xff172133);
const kindaDarkBlue = Color(0xff202641);
class Cinco extends StatefulWidget {
  @override
  _Cinco createState() => _Cinco();
}


class _Cinco extends State<Cinco> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/unnamed.png'),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Record U Once'),
        ),
        body: Center(
          child: RecordingScreen(),
        ),
      ),
    );

  }
}

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  AudioState audioState;
  MicrophoneRecorder _recorder;
  AudioPlayer _audioPlayer;


  @override
  void initState() {

    super.initState();
    _recorder = MicrophoneRecorder()..init();


  }
  void handleAudioState(AudioState state) {
    setState(() {
      if (audioState == null) {
        // Starts recording
        audioState = AudioState.recording;
        _recorder.start();
        // Finished recording
      } else if (audioState == AudioState.recording) {
        audioState = AudioState.play;
        _recorder.stop();
        // Play recorded audio
      } else if (audioState == AudioState.play) {
        audioState = AudioState.stop;
        _audioPlayer = AudioPlayer();
        _audioPlayer.setUrl(_recorder.value.recording.url).then((_) {
          return _audioPlayer.play().then((_) {
            setState(() => audioState = AudioState.play);
          });
        });
        // Stop recorded audio
      } else if (audioState == AudioState.stop) {
        audioState = AudioState.play;
        _audioPlayer.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grabaci??n',
      home: Scaffold(
        backgroundColor: veryDarkBlue,
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: handleAudioColour(),
                ),
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(30),
                  onPressed: () => handleAudioState(audioState),
                  child: getIcon(audioState),
                ),
              ),
              SizedBox(width: 20),
              if (audioState == AudioState.play ||
                  audioState == AudioState.stop)
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kindaDarkBlue,
                  ),
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(30),
                    onPressed: () => setState(() {
                      audioState = null;
                      _recorder.dispose();
                      _recorder = MicrophoneRecorder()..init();
                    }),
                    child: Icon(Icons.replay, size: 50),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color handleAudioColour() {
    if (audioState == AudioState.recording) {
      return Colors.deepOrangeAccent.shade700.withOpacity(0.5);
    } else if (audioState == AudioState.stop) {
      return Colors.green.shade900;
    } else {
      return kindaDarkBlue;
    }
  }

  Icon getIcon(AudioState state) {
    switch (state) {
      case AudioState.play:
        return Icon(Icons.play_arrow, size: 50);
      case AudioState.stop:
        return Icon(Icons.stop, size: 50);
      case AudioState.recording:
        return Icon(Icons.mic, color: Colors.redAccent, size: 50);
      default:
        return Icon(Icons.mic, size: 50);
    }
  }
}