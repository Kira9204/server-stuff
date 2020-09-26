<?php
function getUserIP()
{
    $client  = @$_SERVER['HTTP_CLIENT_IP'];
    $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
    $remote  = $_SERVER['REMOTE_ADDR'];

    if(filter_var($client, FILTER_VALIDATE_IP)) $ip = $client;
    else if(filter_var($forward, FILTER_VALIDATE_IP)) $ip = $forward;
    else $ip = $remote;

    return $ip;
}
$ip = getUserIP();
$url = (isset($_SERVER['HTTPS']) ? 'https' : 'http') . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

// If the request is a CURL or WGET request, just return the IP
if (isset($_SERVER['HTTP_USER_AGENT']) && preg_match('/^(curl|wget)/i', $_SERVER['HTTP_USER_AGENT'])) {
    echo $ip;
    exit();
}
?>
<!DOCTYPE html>
<!--
/////////////////////////////////////////////////////////////////////////////
// Author:      Erik Welander (erik.welander@hotmail.com)
// Modified:    2020-09-26
// Lists the current REAL ip (non-proxied) of the user
/////////////////////////////////////////////////////////////////////////////
-->
<html lang="en-US">
    <head>
        <meta charset="utf-8">
        <link rel="icon" type="image/png" sizes="64x64" href="./favicon.png">
        <title><?=$ip?></title>
        <style>
            /* Occupy 100% of the page */
            html, body
            {
                height: 100%;
                width: 100%;
                margin: 0;
                padding: 0;
                background: #0b0b0b;
                font: normal normal normal 100%/1.4 georgia, serif;
            }

            a {
                color: #858585;
            }
    
            #bg-cover-page {
                position: absolute;
                width: 100%;
                height: 100%;
                background-image: url("./lain.jpg");
                background-position: center center;
                background-repeat: no-repeat;
            }

            #main-page-text {
                position: relative;
                top: 35%;
                margin: 0 auto;
                text-align: center;
                color: #858585;
            }

            #ip-text {
                font-size: 64px;
                font-weight: bold;
            }

            #tip-text {
                font-size: 16px;
            }

            .monospace {
                font-family: monospace;
            }

        </style>
    </head>
    <body>
        <div id="bg-cover-page"></div>
        <div id="main-page-text">
                <a id="ip-text" href="http://<?=$ip?>" target="_blank"><?=$ip?></a>
                <div id="tip-text">This is your real, non-proxied ip. Welcome to the wired.<br>
                This page detects curl/wget clients:<br>
                <span class="monospace">
                    $: curl <?=$url?><br>
                    <?=$ip?>
                </span>
            </div>
        </div>
    </body>
</html>