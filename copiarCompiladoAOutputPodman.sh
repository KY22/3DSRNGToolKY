!#/bin/bash

# 1. Build the image
echo "Build the image"
podman build -t 3dsrngtool-build .

# 2. Create volume and copy built app
echo "Create volume and copy built app"
podman volume create 3DSRNGTool-volume
podman run --rm -v 3DSRNGTool-volume:/3DSRNGTools-output 3dsrngtool-build
# 3. Extract to host
echo "Extract to host"
mkdir -p ./Build
podman run --rm -v 3DSRNGTool-volume:/source -v $(pwd)/Build:$HOME/Git/3DSRNGTool/ alpine cp -r /source/. $HOME/Git/3DSRNGTool/

# 4. Verify the extracted files
echo "Verify extracted files"
ls -la ./Build/

# 5. Clean up (optional)
echo "Clean up, delete volume"
podman volume rm 3DSRNGTool-volume
