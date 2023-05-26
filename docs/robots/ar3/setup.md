# Setting up an AR3 for omcp

## Enabling serial communication

In order to talk to the AR3 robot, omcp connects to the AR3's teensy board via USB.

To enable the serial communication with the teensy, you can install pjrc's udev rules:
```bash
sudo curl https://www.pjrc.com/teensy/00-teensy.rules -o /etc/udev/rules.d/00-teensy.rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Programming the teensy

The teensy board provides a hardware driver to enable omcp to control the AR3.
The hardware driver in use is custom from the original AR3 teensy sketch and needs to be programmed for the teensy.

> Before continuing please ensure you've [installed omcp](docs/install.md), as it contains the custom teensy sketch.

In order to program the teensy you need Teensyduino and the Arduino IDE:
```bash
curl -O https://downloads.arduino.cc/arduino-1.8.15-linux64.tar.xz
curl -O https://www.pjrc.com/teensy/td_154/TeensyduinoInstall.linux64
tar -xf arduino-1.8.15-linux64.tar.xz
chmod 755 TeensyduinoInstall.linux64
./TeensyduinoInstall.linux64 --dir=arduino-1.8.15
```

With the Arduino IDE and Teensyduino installed, you can program your teensy.
For this open the Arduino IDE with the `ar3_teensy_v2.ino` sketch:
```bash
./arduino-1.8.15/arduino ~/omcp/src/ar3_ros/ar3_embedded/ar3_teensy_v2/ar2_teensy_v2.ino
```

Press upload and program your teensy!
In case you're unsure if everything worked, you can use this Python snipped to verify everything worked:
```bash
import serial

dev = serial.Serial('/dev/ttyACM0', baudrate=115200,
                    bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE,
                    stopbits=serial.STOPBITS_ONE, timeout=1)
                    
dev.write(b'V\r\n')
fw_version = dev.readline().strip().decode('utf-8')
if fw_version == '0.0.1':
  print('Custom teensy sketch verified.')
else:
  print('Could not verify custom teensy sketch. Looks like you did something wrong.')
```