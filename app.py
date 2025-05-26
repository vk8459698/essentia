import sys
import essentia.standard as es

if len(sys.argv) != 2:
    print("Usage: python app.py <audio_file>")
    sys.exit(1)

filename = sys.argv[1]

audio = es.MonoLoader(filename=filename)()
key, scale, strength = es.KeyExtractor()(audio)
bpm, confidence, _, _, _ = es.RhythmExtractor2013(method="multifeature")(audio)

print(f"Key: {key} {scale}, Tempo: {bpm:.2f} BPM")
