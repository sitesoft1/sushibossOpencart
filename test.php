<?php
$url = 'https://test.sushiboss.com.ua/image/cache/catalog/ss-1-1000x1000.jpg';
$curl = curl_init();
curl_setopt_array($curl, array(
    CURLOPT_URL => $url,
    CURLOPT_HEADER => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_NOBODY => true));

$header = explode("\n", curl_exec($curl));
curl_close($curl);

print_r($header);
