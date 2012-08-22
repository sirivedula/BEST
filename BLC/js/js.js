function validateMobile(number){
	//var digit=/^((\+)?(\d{2}))?(\d{10}){1}?$/;
	var digit = /^\d{10}$/; 
	return digit.test(number);
}


function registrationValidation(){
	
	var name = document.getElementById('name').value ;
	var number = document.getElementById('number').value ;
	var comment = document.getElementById('comment').value ;/*
	var landlinenumberstd = document.getElementById('landlinenumberstd').value ;
	var landlinenumber = document.getElementById('landlinenumber').value ;*/
	//var transactionid = document.getElementById('transactionid').value ;
	//var customerid = document.getElementById('customerid').value ;
	
	if( name== "" || !isNaN(name) || name=="Your Name" ){
	alert('Please Enter your Name');
	document.getElementById('name').focus();
	return false;
	}
	
	if( number== "" || number=="Number" ){
	alert('Please Enter your correct Number');
	document.getElementById('number').focus();
	return false;
	}
	if( comment== "" || comment=="What are you looking for?" ){
	alert('Please Enter your Comments');
	document.getElementById('comment').focus();
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