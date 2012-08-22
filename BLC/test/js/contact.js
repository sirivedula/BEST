function validateMobile(mobile){
	//var digit=/^((\+)?(\d{2}))?(\d{10}){1}?$/;
	var digit = /^\d{10}$/; 
	return digit.test(mobile);
}


function contactValidation(){
	
	var fname = document.getElementById('fname').value ;
	var lname = document.getElementById('lname').value ;
	var email = document.getElementById('email').value ;
	var mobile = document.getElementById('mobile').value ;
	var comments = document.getElementById('comments').value ;
	var company = document.getElementById('company').value ;
		
	if( fname== "" || !isNaN(fname) ){
	alert('Please fill your first name');
	document.getElementById('fname').focus();
	return false;
	}
	
	if( lname== "" || !isNaN(lname) ){
	alert('Please fill your last name');
	document.getElementById('lname').focus();
	return false;
	}
	
	if( email== "" ){
	alert('Please fill your correct email address');
	document.getElementById('email').focus();
	return false;
	}
	
	if( mobile== "" || !(validateMobile(mobile)) ){
	alert('Please fill your correct mobile number');
	document.getElementById('mobile').focus();
	return false;
	}
	
	if( comments== "" ){
	alert('Please fill your comments');
	document.getElementById('comments').focus();
	return false;
	}
	
	if( company== "" ){
	alert('Please fill your company');
	document.getElementById('company').focus();
	return false;
	}
	
		/*
	if( landlinenumberstd== "" || landlinenumberstd== "STD Code" || isNaN(landlinenumberstd) ){
		document.getElementById('result').innerHTML ='Please Enter Your Airtel Landline Number STD code';
		return false;
		}	
	
	if( landlinenumber== "" || isNaN(landlinenumber) ){		
		document.getElementById('result').innerHTML ='Please Enter Your Airtel Landline Number.';
		return false;
		}	*/
	
	return true;
}