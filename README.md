# RightClickHEVC

RightClickHEVC integrates a custom batch script into the Windows Explorer context menu, allowing you to compress MP4 videos using HEVC (H.265) encoding—often resulting in significant file size reduction.

### How to Install RightClickHEVC

Follow these steps to add the batch script to your context menu:

1. **Open Registry Editor:**
   - Press `Win + R`, type `regedit`, and hit **Enter**.

2. **Navigate to the MP4 file association:**
   - Go to:  
     `HKEY_CLASSES_ROOT\SystemFileAssociations\.mp4\`

3. **Create the required registry keys:**
   - If it doesn’t already exist, right-click on the `.mp4` key, choose **New > Key**, and name it `shell`.
   - Under the `shell` key, create a new key named `deflate`.

4. **Set the context menu label:**
   - Click on the `deflate` key.
   - In the right pane, double-click the `(Default)` value and set its data to `Deflate Video` (or any label you prefer).

5. **Create the command key:**
   - Inside the `deflate` key, create another key named `command`.

6. **Specify the command to run:**
   - Select the `command` key.
   - In the right pane, double-click the `(Default)` value and set its data to:
     ```
     "C:\Path\To\ffmpeg265.bat" "%1"
     ```
   - **Note:** Replace `C:\Path\To\ffmpeg265.bat` with the full path to your batch script.

### How It Works

After completing these steps, you can compress an MP4 file by:
- Right-clicking the file in File Explorer.
- Selecting **Show more options** (if needed).
- Clicking **Deflate Video**.

This will run the batch script, creating a new file in the same directory named `file_name_Compressed.mp4` using HEVC (H.265) encoding.

---

**Important:**  
Ensure that FFmpeg is installed and added to your system PATH, as the script depends on it to perform the compression.
---

## FFmpeg Installation

This project relies on FFmpeg for video compression. Please follow the steps below to install FFmpeg on your system.

### Windows

1. **Download FFmpeg:**
   - Visit the [FFmpeg official download page](https://ffmpeg.org/download.html) and select the Windows version.
   - Alternatively, you can download a static build from [Gyan.dev](https://www.gyan.dev/ffmpeg/builds/).

2. **Extract the Archive:**
   - Unzip the downloaded archive to a folder of your choice (e.g., `C:\ffmpeg`).

3. **Add FFmpeg to the System PATH:**
   - Press `Win + X` and select **System**.
   - Click on **Advanced system settings**.
   - In the **System Properties** window, click on **Environment Variables...**.
   - Under **System variables**, locate and select the **Path** variable, then click **Edit**.
   - Click **New** and add the path to the FFmpeg `bin` folder (e.g., `C:\ffmpeg\bin`).
   - Click **OK** to close all dialogs.

4. **Verify Installation:**
   - Open a new command prompt and run:
     ```batch
     ffmpeg -version
     ```
   - If installed correctly, you should see FFmpeg version details.

## Mac & Linux
### macOS Integration via Automator

To add a Finder Quick Action (formerly “Service”) so you can right-click an MP4 file:

1. **Open Automator:**  
   Find Automator in your Applications folder and launch it.

2. **Create a New Quick Action:**  
   - Choose **New Document** > **Quick Action**.
   - Set the workflow to receive **"files or folders"** in **Finder**.

3. **Add a “Run Shell Script” Action:**  
   - In the search bar, find and drag **Run Shell Script** into the workflow.
   - Set **Shell** to `/bin/bash` and **Pass input:** to **"as arguments"**.
   - Paste the following code (adjust the script path if needed):
     ```bash
     for f in "$@"; do
         /path/to/ffmpeg265.sh "$f"
     done
     ```
     *(Replace `/path/to/ffmpeg265.sh` with the actual path where you saved your script.)*

4. **Save the Quick Action:**  
   Save it as **"Deflate Video"** (or any name you prefer).

Now, when you right-click an MP4 file in Finder, you can select **Quick Actions > Deflate Video** to run the compression.

---

## Linux Integration with Nautilus Scripts

For GNOME’s Nautilus file manager (or similar):

1. **Create the Nautilus Script:**
   - Create a new file named **Deflate Video** in the directory:
     ```
     ~/.local/share/nautilus/scripts/
     ```
     (If the `scripts` folder does not exist, create it.)

2. **Add the Script Content:**

   Paste the following code into the file:
   ```bash
   #!/bin/bash
   for f in "$@"; do
       # Process only .mp4 files
       if [[ "$f" == *.mp4 ]]; then
           dir=$(dirname "$f")
           filename=$(basename "$f" .mp4)
           output="${dir}/${filename}_Compressed.mp4"
           ffmpeg -i "$f" -c:v libx265 "$output"
       else
           echo "Skipping non-mp4 file: $f"
       fi
   done
   ```

3. **Make the Script Executable:**
   Run:
   ```bash
   chmod +x ~/.local/share/nautilus/scripts/Deflate\ Video
   ```

4. **Using the Script:**
   - In Nautilus, right-click any MP4 file.
   - Navigate to **Scripts** in the context menu.
   - Select **Deflate Video** to compress the file.

---

## Installing FFmpeg

Ensure FFmpeg is installed and accessible from your terminal:

### macOS

**Using Homebrew:**
```bash
brew install ffmpeg
```

Alternatively, download FFmpeg from the [FFmpeg website](https://ffmpeg.org/download.html).

### Linux (Debian/Ubuntu)

**Using apt:**
```bash
sudo apt update
sudo apt install ffmpeg
```

For other distributions, use your package manager or check the [FFmpeg download page](https://ffmpeg.org/download.html).

---

By following these instructions, you’ll have a working shell script to compress MP4 files with HEVC encoding and know how to integrate it into your right-click context menu on both macOS and Linux.
