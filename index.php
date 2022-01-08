<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WIFI ESP connect</title>
</head>

<body>
    <?php

    include __DIR__ . '/vendor/autoload.php';

    use Sanchescom\WiFi\WiFi;

    class Example
    {
        public $device;

        /**
         * @throws Exception
         */
        public function getAllNetworks()
        {
            $networks = WiFi::scan()->getAll();

            foreach ($networks as $network) {
                echo $network . "\n";
            }
        }

        /**
         * @param $ssid
         * @param $password
         */
        public function connect($ssid, $password)
        {
            try {
                WiFi::scan()->getBySsid($ssid)->connect($password, $this->device);
            } catch (Exception $exception) {
                echo $exception->getMessage();
            }
        }

        /**
         * @throws Exception
         */
        public function disconnect()
        {
            $networks = WiFi::scan()->getConnected();

            foreach ($networks as $network) {
                $network->disconnect($this->device);
            }
        }
    }

    $example = new Example();
    try {
        $example->device = 'en0';
        $example->getAllNetworks();
        $example->connect('Anh Viet', '00000000');
        $example->disconnect();
    } catch (Exception $e) {
        //
    }
    ?>
</body>

</html>