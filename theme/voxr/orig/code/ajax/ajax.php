<?php
	if (!(isset($_SERVER['HTTP_X_REQUESTED_WITH']) AND strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest')) {
	   die();
	}

	$from = 'your@email.com';
	$subject = 'Subject';


	$name = isset($_POST["name"]) ? trim($_POST["name"]) : "";
	$email = isset($_POST["email"]) ? trim($_POST["email"]) : "";
	$message = isset($_POST["message"]) ? trim($_POST["message"]) : "";

	$response = '';
	$error = false;
	

	if (!$message){
		$error = true;
		$response = 'Please enter a message.';
	}


	$pattern = "^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$^";
	if(!preg_match_all($pattern, $email, $out)) {
		$error = true;
		$response = 'Please enter a valid email.';
	}
	if (!$email){
		$error = true;
		$response = 'Please enter an email.';
	}

	if (!$name){
		$error = true;
		$response = 'Please enter a name.';
	}

	if (!$error){

 		$headers = "From: ".$name." <".$from.">\r\nReply-To: ".$email."";

		//send the email
		$sent = mail($email,$subject,$message,$headers); 
		
		if ($sent){
			$response = 'Message sent.';
		}else{
			$response = 'Message not sent. An error has occurred.';
		}
	}


	$data = array(
		'response' => $response,
		'error' => $error
	);

	header('Content-Type: application/json');

	echo json_encode($data);
?>