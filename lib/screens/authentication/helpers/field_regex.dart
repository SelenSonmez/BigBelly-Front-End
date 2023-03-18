// username consists of alphanumberic chars. lower or uppercase
// username allowed of the dot and underscore but no consecutively. e.g: flutter..regex
// they can't be used as first or last char.
// length must be between 5-20
final userNameRegex =
    RegExp(r'^[a-zA-Z0-9]([._](?![._])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$');

// https://www.w3resource.com/javascript/form/email-validation.php
// Example of valid email id

// mysite@ourearth.com
// my.ownsite@ourearth.org
// mysite@you.me.net

// Example of invalid email id

// mysite.ourearth.com [@ is not present]
// mysite@.com.my [ tld (Top Level domain) can not start with dot "." ]
// @you.me.net [ No character before @ ]
// mysite123@gmail.b [ ".b" is not a valid tld ]
// mysite@.org.org [ tld can not start with dot "." ]
// .mysite@mysite.org [ an email should not be start with "." ]
// mysite()*@gmail.com [ here the regular expression only allows character, digit, underscore, and dash ]
// mysite..1234@yahoo.com [double dots are not allowed]
final emailRegex = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');

final passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\?$&*~.]).{8,}$');
