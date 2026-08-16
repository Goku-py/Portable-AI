# Portable AI Pendrive

Turn any USB stick into an offline AI chatbot. No internet needed after setup.

## What you need

- A USB pendrive — **8 GB minimum** (most models fit; bigger models need a bigger drive)
- Any Windows PC with internet — only for the one-time model download

## Setup — one time only

**1. Get a pendrive (8 GB minimum).**
Smaller drives only fit tiny models (1-3B). Model file sizes by PC class: 0.5B = 0.5 GB, 1.5B = 1 GB, 3B = 2 GB, 7B = 4.7 GB, 12B = 9 GB, 32B = 20 GB, 72B = 44 GB.

**2. Format it to exFAT.**
Right-click the drive in File Explorer → **Format** → File system: **exFAT** → Start.
(FAT32 cannot hold files over 4 GB, and most AI models are bigger.)

**3b. Get the latest llamafile from GitHub:**
The official project is https://github.com/mozilla-ai/llamafile. Check its **Releases** page and download the latest `llamafile-<version>` file, then copy it over the one on the pendrive (rename it to `llamafile-<version>.exe` if the version differs — `run-ai.bat` looks for that exact name).

**4. Copy these 3 files onto the pendrive:**
`check-system.bat`, `run-ai.bat`, `llamafile-<version>.exe`

**5. Run `check-system.bat` on the target PC** (the PC that will run the AI).
It checks the PC's hardware, searches the internet for the best-fitting model, and prints the exact model name plus a direct download link.

**6. Download the model and copy it to the pendrive.**
On any PC with internet, open the link, download the `.gguf` file, and copy it into the pendrive (same folder as the other files).

Done. The pendrive is now a portable AI.

## Using it — on any PC, no internet

1. Plug in the pendrive, double-click `run-ai.bat`.
2. It checks the files, loads the model (a few minutes on slow USB), then opens your browser automatically.
3. Chat. Everything stays on the PC — nothing is uploaded anywhere.

## Tips

- The AI runs on the PC's CPU — no special GPU needed.
- USB 3.0 sticks load models much faster (seconds instead of minutes).
- Close the `run-ai.bat` window to stop the AI.
- If the browser doesn't open by itself: type `http://127.0.0.1:8080/` manually.

## Troubleshooting

| Problem                                                          | Fix                                                                                  |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| "Missing: ... copy it to this pendrive first"                    | The model `.gguf` file is not on the pendrive. Run `check-system.bat` again and copy the file. |
| Loading takes very long                                          | Normal on USB 2.0 sticks (a few minutes). A USB 3.0 stick is much faster.             |
| `check-system.bat` says "No internet found"                      | It falls back to a proven default model — still works fine.                           |
| Window closes / nothing happens                                  | Make sure `llamafile-0.10.5.exe` and the `.gguf` are in the same folder as `run-ai.bat`. |
