#!/bin/bash

# Function to simulate the output of `free -h`
function show_memory_usage {
  echo "💻 Memory Usage (simulated):"
  free -h | awk '{if(NR==2) print "Mem: " $2 "\tUsed: " $3 "\tFree: " $4 "\tShared: " $5 "\tBuff/Cache: " $6 "\tAvailable: " $7} NR==3{print "Swap: " $2 "\tUsed: " $3 "\tFree: " $4}'
  echo "-------------------------------------"
}

# Step 1: User runs the command
echo "🔧 Step 1: User runs the Firefox command"
echo "Running: firefox &"
echo "The user has typed 'firefox' in the terminal or clicked the Firefox icon."
sleep 2

# Show memory usage before starting Firefox
show_memory_usage
sleep 2

# Step 2: Shell searches for the program file
echo "🔍 Step 2: Shell searches for the firefox binary in \$PATH"
echo "The shell will look for the firefox executable in directories listed in \$PATH."
sleep 2

# Step 3: Checking file permissions
echo "🔐 Step 3: Shell checks if the user has execute permission on the firefox binary"
echo "The system verifies whether the user has the necessary permission to run Firefox."
sleep 2

# Step 4: fork() → Creates a child process
echo "🌱 Step 4: Shell uses fork() to create a child process"
echo "The shell creates a child process to run Firefox. The child process is a copy of the shell process."
sleep 2

# Step 5: exec() → Loads the new program (Firefox)
echo "🔄 Step 5: Shell uses exec() to replace the child process with the Firefox program"
echo "The shell replaces the child process with Firefox. It’s no longer the shell, but Firefox now."
sleep 2

# Step 6: Kernel manages resources
echo "🧩 Step 6: Kernel manages resources: memory, CPU, and I/O for Firefox"
echo "The kernel allocates memory, CPU time, and other resources to Firefox."
sleep 2

# Step 7: Firefox starts and is running
echo "🖥️ Step 7: Firefox starts and begins running"
echo "Firefox launches on the screen. It starts opening its GUI and loading websites."
sleep 3

# Show memory usage after starting Firefox
show_memory_usage
sleep 2

# Start Firefox in the background and capture its PID
firefox &

# Get the PID of the Firefox process
FIREFOX_PID=$!

echo "✅ Firefox is now running in the background with PID: $FIREFOX_PID"
echo "You can see Firefox's process in the list of running processes."
sleep 2

# Step 8: Monitor Firefox running and show resources usage
echo "🧠 Step 8: Firefox is running and using system resources"
echo "You can monitor its resource usage with 'top' or 'htop'."
sleep 2

# Simulate Firefox running (you can use an actual program here in real-world use)
echo "🖥️ Firefox is now actively running, displaying websites, using network resources, and consuming memory."
sleep 5

# Show memory usage during Firefox running
show_memory_usage
sleep 2

# Step 9: Program ends and returns resources
echo "🏁 Step 9: Firefox is closing. Releasing resources..."
kill $FIREFOX_PID  # Kill the Firefox process to simulate program exit
sleep 1

# Step 10: Kernel releases resources
echo "🔄 Kernel releases the resources used by Firefox"
echo "The kernel will reclaim all memory and CPU that was allocated to Firefox."
sleep 2

# Show memory usage after Firefox ends
show_memory_usage
sleep 2

# Final step: Process ends
echo "✅ Step 10: Firefox has stopped, and all resources have been released."
echo "The process with PID $FIREFOX_PID has ended, and all associated resources are now freed."
sleep 2

# Final message
echo "🎉 All resources for Firefox are now free! You can now run other processes on the system."
