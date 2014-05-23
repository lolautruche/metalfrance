<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="attribute-header">
    <h2 class="mf-title mf-noicon">{"Activate account"|i18n("design/ezwebin/user/activate")}</h2>
</div>

<div class="user-activate mf-body">

  <div class="mf-top">

	<p>
	{if $account_activated}
	    {if $is_pending}
	        {'Your email address has been confirmed. An administrator needs to approve your sign up request, before your login becomes valid.'|i18n('design/standard/user')}
	    {else}
	        {'Your account is now activated.'|i18n('design/standard/user')}
	    {/if}
	{elseif $already_active}
	    {'Your account is already active.'|i18n('design/standard/user')}
	{else}
	    {'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n('design/standard/user')}
	{/if}
	</p>
	
	<p><a href={'/'|ezurl}>&laquo; {'Retour à Metal France'|i18n( 'extension/metalfrance' )}</a></p>
  </div>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>