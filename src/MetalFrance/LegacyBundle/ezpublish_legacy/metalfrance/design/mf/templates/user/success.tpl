<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="attribute-header">
    <h2 class="mf-title mf-noicon">{"User registered"|i18n("design/ezwebin/user/success")}</h2>
</div>

<div class="user-success mf-body">

	{if $verify_user_email}
	
	<div class="feedback mf-top">
		<p>
		{'Your account was successfully created. An email will be sent to the specified address. Follow the instructions in that email to activate your account.'|i18n('design/ezwebin/user/success')}
		</p>
	</div>
	{else}
	<div class="feedback">
	    <h3>{"Your account was successfully created."|i18n("design/ezwebin/user/success")}</h3>
	</div>
	{/if}

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>