<?php header($_SERVER['SERVER_PROTOCOL']." 404 Not Found"); ?>
<!DOCTYPE html>
<!--
/////////////////////////////////////////////////////////////////////////////
// Author:      Erik Welander (erik.welander@hotmail.com)
// Modified:    2020-09-26
// Unconfigured domain response page. Will return a 404.
/////////////////////////////////////////////////////////////////////////////
-->
<html lang="en-US">
    <head>
        <meta charset="utf-8">
        <link rel="icon" type="image/png" sizes="64x64" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAH7SURBVHhe7ZpLTsQwDIY7IFaskNiAkNjMhpOgOQw3ZsmSO0Bc/RmlmTaN82xrf1Jlp4/E/uuk4TEowjn9vp3/4IvkDlYsKgCsWMQLcLMIPv98n+AOcwukvR66RqxdLwV3HP9+nQKwYgkKYErpA+6Iab/CvSkz0/6EO2LaZ7gjpv0Od1ME14A9oGtAJroVhhWLCgArFhUAViy73wdw0X2AhwoAKxYVADaaUltn6sc9cJrLQ248rK8A594l1gLm9JkSj/9M1hRYS8Yn5n5uny4pz0YLkBMYwXm+tlAuWRUQW64pwaY8kzIlu34FKOCUoEu9fSJKgJIDWtzEU0TwSe0juQJiB8wRr4bwPkWmAAVqD5yqRswYnHhWBVjrxL8eM2hp3GrkxpNUASXm7FYICtDjbYaoEU9SBVAg9sCpruTEU2QR3DMqAKxYggKY1f4CdxOYeL7gFiP7t8JzC0/ou2zxx4m9bw1uPNWnADcBl5xnY+m2BrhvYuntt6DrIkiJ90yeaCJASim3KH+iWQVwEmqVPNF0CsQk1jJ5IlsAE/A93BHTfoE7CyU4l+TSeS6mj0e4I6b9BHcW/eswrFhUAFixqACwV3rvzGoyl5tWAOyEI1bBUk7i/1d43PRIFYE2fdddnzQR7I53su2VIoK73Z8IYDmqEEf/OUfhMwz/HGAUDVtLyd0AAAAASUVORK5CYII=">
        <title>Unmapped page</title>
        <style>
            body {
                background: #f7f7f7;
            }
            .text-bold {
                font-weight: bold;
            }
            .text-underline {
                text-decoration: underline;
            }
            .text-black {
                color: #000;
            }
            .table-space>td {
                padding-bottom: 10px;
                padding-right: 10px;
            }
        </style>
    </head>
    <body>
        <h1>Unmapped page</h1>
        <h3>The address you entered does not belog to any configured domains on this server.<br>
        Make sure that the address that you've entered is correct.</h3>
        <?php $url = (isset($_SERVER['HTTPS']) ? 'https' : 'http') . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; ?>
        <table>
            <tr class="table-space">
                <td>Requested resource: </td>
                <td><a href="<?=$url?>" class="text-black text-bold"><?=$url?></a></td>
            </td>
            <tr>
                <td>Contact: </td>
                <td><a href="mailto:erik.welander@hotmail.com?subject=<?=rawurlencode('Unmapped page: '.$url)?>" class="text-black text-bold">erik.welander@hotmail.com</td>
            </td>
            <tr>
                <td></td>
                <td><a href="https://erikwelander.se" target="_blank" class="text-black text-bold">erikwelander.se</a></td>
            </td>
        </table>
    </body>
</html>
