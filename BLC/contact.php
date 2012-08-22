<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>BLC : Contact Us Thankyou</title>
<link href="css/stylesheet.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/js.js" > </script>
<!--[if lte IE 6 ]>	
<script src="js/DD_belatedPNG.js" type="text/javascript" charset="utf-8"></script> 
<script>  
DD_belatedPNG.fix('.png_bg');</script> 	
<![endif]-->
</head>

<body>
<div class="site_wrapper">
<div class="top_wrapper">
<div class="logo"><a href="index.html"><img src="images/logo.png" alt="BLC" class="png_bg" /></a></div>
<div class="navigation">
<ul>
<li><a href="index.html" class="home"><img src="images/home.gif" alt="Home" /></a></li>
<li><a href="aboutus.html">about us</a></li>
<li><a href="services.html">services</a></li>
<li><a href="jobs.html">jobs@blc</a></li>
<li><a href="news.html">in the news</a></li>
<!--<li><a href="#">tutorial videos</a></li>-->
<li><a href="#">contact us</a></li>
</ul>
</div>
<div class="call"><h2>call us: (209) 201 - 6850</h2></div>
</div>
<div class="clear"></div>
<div class="content_wrapper" style="padding-top:200px; text-align:center; min-height:200px;">
<?php
$to      = 'info@balilearning.com';
$subject = "Contact Us from website";
$fname = $_POST['fname'];
$lname = $_POST['lname'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];
$mycomment = $_POST['comments'];
$company = $_POST['company'];
//$ipi = getenv("REMOTE_ADDR");
$httprefi = getenv ("HTTP_REFERER");
//$httpagenti = getenv ("HTTP_USER_AGENT");
//$subject = "Feedback from $name";
//$message = 'hello';
//header = "Content-type: text/html; charset=iso-8859-1\r\n"; 
$message = "
<table width='500' border='1' cellspacing='0' cellpadding='4' style='font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:normal; color:#000000;'>
  <tr>
    <td colspan='2' align='center' valign='middle'><span style='color:#FF0000;'><strong>Contact us from Website</strong></span></td>
  </tr>
  <tr>
    <td width='50%' align='left' valign='middle'><strong>First Name :</strong></td>
    <td width='50%' align='left' valign='middle'>$fname</td>
  </tr>
  <tr>
    <td width='50%' align='left' valign='middle'><strong>Last Name :</strong></td>
    <td width='50%' align='left' valign='middle'>$lname</td>
  </tr>
  <tr>
    <td width='50%' align='left' valign='middle'><strong>Email:</strong></td>
    <td width='50%' align='left' valign='middle'>$email</td>
  </tr>
  <tr>
    <td align='left' valign='middle'><strong>Mobile Number :</strong></td>
    <td align='left' valign='middle'>$mobile</td>
  </tr>
  <tr>
    <td align='left' valign='middle'><strong>Comments :</strong></td>
    <td align='left' valign='middle'>$mycomment</td>
  </tr>
  <tr>
    <td align='left' valign='middle'><strong>Company :</strong></td>
    <td align='left' valign='middle'>$company</td>
  </tr>
  
  <tr>
    <td align='left' valign='middle'><strong>Page :</strong></td>
    <td align='left' valign='middle'>$httprefi</td>
  </tr>
</table>

";
//header('Location: http://www.balilearning.com/');

// Always set content-type when sending HTML email
$headers = "MIME-Version: 1.0" . "\r\n";
$headers .= "Content-type:text/html;charset=iso-8859-1" . "\r\n";

// More headers
//$headers .= 'From: <webmaster@balilearning.com>' . "\r\n";
//$headers .= 'Cc: bhupeshlohani@gmail.com' . "\r\n";

mail($to, $subject, $message, $headers);
echo "<h2>Thank you for contacting us. We will get back to you soon.</h2>";
?>
<a href = "javascript:history.back()">Go back to previous page</a> 
</div>
<div class="clear"></div>
<div class="bottom_wrapper">
<p class="links"><a href="contactus.html">Contact Us</a>  |  <a href="#">Site Map</a>  |  <a href="#">Terms &amp; Conditions</a></p>
</div>
</div>
</body>
</html>
