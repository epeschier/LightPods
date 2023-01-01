#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
 #include <avr/power.h> // Required for 16 MHz Adafruit Trinket
#endif
#include <bluefruit.h>

#define PIN        6

#define NUMPIXELS 16 // Popular NeoPixel ring size

Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRBW + NEO_KHZ800);

#define GREEN pixels.Color(  0, 150,   0)
#define BLUE pixels.Color(  0,   0, 150)
#define RED pixels.Color(150,   0,   0)
#define OFF pixels.Color(0,   0,   0)

/* Nordic Led-Button Service (LBS)
 * LBS Service: 00001523-1212-EFDE-1523-785FEABCD123
 * LBS Button : 00001524-1212-EFDE-1523-785FEABCD123
 * LBS LED    : 00001525-1212-EFDE-1523-785FEABCD123
 */

const uint8_t LBS_UUID_SERVICE[] =
{
  0x23, 0xD1, 0xBC, 0xEA, 0x5F, 0x78, 0x23, 0x15,
  0xDE, 0xEF, 0x12, 0x12, 0x23, 0x15, 0x00, 0x00
};

const uint8_t LBS_UUID_CHR_BUTTON[] =
{
  0x23, 0xD1, 0xBC, 0xEA, 0x5F, 0x78, 0x23, 0x15,
  0xDE, 0xEF, 0x12, 0x12, 0x24, 0x15, 0x00, 0x00
};

const uint8_t LBS_UUID_CHR_LED[] =
{
  0x23, 0xD1, 0xBC, 0xEA, 0x5F, 0x78, 0x23, 0x15,
  0xDE, 0xEF, 0x12, 0x12, 0x25, 0x15, 0x00, 0x00
};

BLEService        lbs(LBS_UUID_SERVICE);
BLECharacteristic lsbButton(LBS_UUID_CHR_BUTTON);
BLECharacteristic lsbLED(LBS_UUID_CHR_LED);
//BLECharacteristic batteryLevelChar("2A19", BLERead);

#define DELAYVAL 100 // Time (in milliseconds) to pause between pixels

const int knockSensor = A0;  // the piezo is connected to analog pin 0
const int threshold = 250;   // threshold value to decide when the detected sound is a knock or not

int ledState = LOW;
const unsigned long debounceTime = 500;
unsigned long time;

bool playGameEnd = false;
uint32_t gameEndColor;

void setup() {
  Serial.begin(115200);

  initializeLed();

  setupBluetooth();

  time = millis();
}

void initializeLed() {
  Serial.println("Initialize LEDs");
  pixels.begin();
  pixels.setBrightness(20);
  pixels.clear();

  pixels.setPixelColor(0, GREEN);
  pixels.show();
  delay(500);
}

void loop() {
  readKnock();

  if (playGameEnd == true) {
    colorRotate(gameEndColor, 500);
  }
 // colorWipe(pixels.Color(150,   0,   0), 50); // Red
 // colorWipe(pixels.Color(  0, 150,   0), 50); // Green
 // colorWipe(pixels.Color(  0,   0, 150), 50); // Blue
}

void readKnock() {
  int sensorReading = analogRead(knockSensor);

  // if the sensor reading is greater than the threshold:
  if (sensorReading > threshold) {
    unsigned long currentTime = millis();
    unsigned long elapsedTime = currentTime - time;
    if (elapsedTime > debounceTime) {
      notifyButtonPress();
      time = millis();
    }
  }
}

void colorWipe(uint32_t color, int wait) {
  for(int i=0; i<pixels.numPixels(); i++) { 
    pixels.setPixelColor(i, color);
    pixels.show();
    delay(wait);
  }
}

void colorRotate(uint32_t color, int wait) {
  for (int offset = 0; offset < 2; offset++) {
    for(int i = offset; i < pixels.numPixels(); i += 2) { 
      pixels.setPixelColor(i, color);
      pixels.setPixelColor((i + 1) & 0x0f, pixels.Color(0, 0, 0));
    }
    pixels.show();
    delay(wait);
  }
}

void notifyButtonPress() {
  if (Bluefruit.connected(0) && lsbButton.notifyEnabled(0))
  {
    lsbButton.notify8(0, 0x01);
  }
}

void setupBluetooth() {
  Serial.println("Lightpod bluetooth BLE");
  Serial.println("------------------\n");

  // Initialize Bluefruit with max concurrent connections as Peripheral = MAX_PRPH_CONNECTION, Central = 0
  Serial.println("Initialise the Bluefruit nRF52 module");
  Bluefruit.begin(1, 0);
  Bluefruit.setName("Lightpod");
  Bluefruit.Periph.setConnectCallback(connect_callback);
  Bluefruit.Periph.setDisconnectCallback(disconnect_callback);

  configureLedCharacteristic();
  configureButtonCharacteristic();

  //configureBatteryCharacteristic();

  startAdvertising();
}

void configureLedCharacteristic() {
  Serial.println("Configuring the LED Service");
  
  lbs.begin();
  // Properties = Read + Write
  // Permission = Open to read, Open to write
  // Fixed Len  = 4 (LED state)
  lsbLED.setProperties(CHR_PROPS_READ | CHR_PROPS_WRITE);
  lsbLED.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  lsbLED.setFixedLen(4);
  lsbLED.begin();
  //lsbLED.write8(0x01); // led = on when connected
  lsbLED.setWriteCallback(led_write_callback);
}

void led_write_callback(uint16_t conn_hdl, BLECharacteristic* chr, uint8_t* data, uint16_t len)
{
  (void) conn_hdl;
  (void) chr;
  (void) len;

  decodePixelCommand(data, len);
}

void decodePixelCommand(uint8_t* data, uint16_t len) {
   // len should be 4
  if (len == 4) {
    if (data[3] == 0) {
      setAllPixelsToColor(data[0], data[1], data[2]);
    }
    else if (data[3] == 1) {
      pixels.setBrightness(data[0]);
      pixels.show();
    } 
    
    if (data[3] == 2) {
      gameEndColor = pixels.Color(data[0], data[1], data[2]);
      playGameEnd = true;
    } 
    else {
      playGameEnd = false;
    }
  }
}

void turnAllPixelsOff() {
  setAllPixelsToColor(0, 0, 0);
  pixels.show();
}

void setAllPixelsToColor(uint8_t r, uint8_t g, uint8_t b) {
  for(int i = 0; i < pixels.numPixels(); i++) { 
    pixels.setPixelColor(i, pixels.Color(r, g, b));
  }
  pixels.show();
}

void configureButtonCharacteristic() {
  lsbButton.setProperties(CHR_PROPS_READ | CHR_PROPS_NOTIFY);
  lsbButton.setPermission(SECMODE_OPEN, SECMODE_NO_ACCESS);
  lsbButton.setFixedLen(1);
  lsbButton.begin();
}

/*
void configureBatteryCharacteristic() {
  Serial.println("Configuring the Battery Service");
  
  batteryLevelChar.begin();
  batteryLevelChar.setWriteCallback(getBatteryLevel_callback);
}

void getBatteryLevel_callback() {
  int batteryLevel = 23;
  batteryLevelChar.writeValue(batteryLevel);
}
*/

void connect_callback(uint16_t conn_handle)
{
  // Get the reference to current connection
  BLEConnection* connection = Bluefruit.Connection(conn_handle);

  char central_name[32] = { 0 };
  connection->getPeerName(central_name, sizeof(central_name));

  Serial.print("Connected to ");
  Serial.println(central_name);

  pixels.setPixelColor(1, BLUE);
  pixels.show();
}

/**
 * Callback invoked when a connection is dropped
 * @param conn_handle connection where this event happens
 * @param reason is a BLE_HCI_STATUS_CODE which can be found in ble_hci.h
 */
void disconnect_callback(uint16_t conn_handle, uint8_t reason)
{
  (void) conn_handle;
  (void) reason;

  Serial.print("Disconnected, reason = 0x"); 
  Serial.println(reason, HEX);

  playGameEnd = false;
  turnAllPixelsOff();
}

void startAdvertising(void)
{
  Serial.println("Setting up the advertising");

  // Advertising packet
  Bluefruit.Advertising.addFlags(BLE_GAP_ADV_FLAGS_LE_ONLY_GENERAL_DISC_MODE);
  Bluefruit.Advertising.addTxPower();

  // Include HRM Service UUID
  Bluefruit.Advertising.addService(lbs);

  // Secondary Scan Response packet (optional)
  // Since there is no room for 'Name' in Advertising packet
  Bluefruit.ScanResponse.addName();
  
  /* Start Advertising
   * - Enable auto advertising if disconnected
   * - Interval:  fast mode = 20 ms, slow mode = 152.5 ms
   * - Timeout for fast mode is 30 seconds
   * - Start(timeout) with timeout = 0 will advertise forever (until connected)
   * 
   * For recommended advertising interval
   * https://developer.apple.com/library/content/qa/qa1931/_index.html   
   */
  Bluefruit.Advertising.restartOnDisconnect(true);
  Bluefruit.Advertising.setInterval(32, 244);    // in unit of 0.625 ms
  Bluefruit.Advertising.setFastTimeout(30);      // number of seconds in fast mode
  Bluefruit.Advertising.start(0);                // 0 = Don't stop advertising after n seconds  
}
