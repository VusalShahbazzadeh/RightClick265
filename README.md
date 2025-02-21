# RightClickHEVC
Adding the provided batch script to the registry will allow you to override the encoding and deflate your videos often resulting in considerate size improvement.
To do this apply following steps:
1. Open Registtry and navigate to  "HKEY_CLASSES_ROOT\SystemFileAssociations\\.mp4\\"
2. Create a Key named "shell"
3. In shell create a Key named "deflate"
4. Assign "Deflate Video" (or any other to your liking) value to "(Default)"
5. in deflate create a Key named "command"
6. Assign "path_to_script\ffmpeg265.bat" "%1" to "(Default)"

This will allow you to right click on .mp4 files -> "Show more options" -> "Deflate Video", which will create a file in the same directory named "file_name_Compressed.mp4" with h256 (HVEC) encoding
