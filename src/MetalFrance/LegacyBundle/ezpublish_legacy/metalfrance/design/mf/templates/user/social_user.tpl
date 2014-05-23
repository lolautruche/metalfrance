    <div class="block">
      <p><a href={"/comment/setting"|ezurl}>&raquo; {"My comment settings"|i18n("ezcomments/ezwebin/user/edit")}</a></p>
      {*<p><a href={"notification/settings"|ezurl}>{"My notification settings"|i18n("design/ezwebin/user/edit")}</a></p>*}
    </div>
    
    <div class="block">
      {def $accountType = $user.data_map.account_type.content|downcase}
      <label>{"Type de compte :"|i18n( "extension/metalfrance/user" )}</label><div class="labelbreak"></div>
      <p class="box"><a href={$user.data_map.user_account.content.login|ezurl} target="_blank"><img src={concat( "socialuser/", $accountType, '.png' )|ezimage} alt="{$accountType}" /></a></p>
      <p class="note">{"Pour modifier vos informations personnelles, veuillez vous connecter sur votre compte"|i18n( 'extension/metalfrance/user' )} <a href={$user.data_map.user_account.content.login|ezurl} target="_blank">{$accountType|upfirst}</a></p>
    </div>
    
    <div class="block">
      <label>{"Name"|i18n("design/ezwebin/user/edit")} :</label><div class="labelbreak"></div>
      <p class="box">{$user.name|wash}</p>
    </div>
    
    <div class="block">
      <label>{"Email"|i18n("design/ezwebin/user/edit")} :</label><div class="labelbreak"></div>
      <p class="box">{$user.data_map.user_account.content.email}</p>
    </div>
    
    <div class="block">
      <label>{"Avatar"|i18n( "extension/metalfrance/user" )} :</label><div class="labelbreak"></div>
	{if $user.data_map.remote_avatar.has_content}
      <p class="box"><img src={$user.data_map.remote_avatar.content|ezurl} alt="{"Avatar de %user"|i18n( 'extension/metalfrance/user',, hash( '%user', $user.name ) )}"/></p>
    {elseif $user.data_map.local_avatar.has_content}
      <p class="box"><img src={$user.data_map.local_avatar.content.medium.url|ezurl} alt="{"Avatar de %user"|i18n( 'extension/metalfrance/user',, hash( '%user', $user.name ) )}"/></p>
    {else}
      <p class="box">{'Aucun avatar'|i18n( 'extension/metalfrance/user' )}</p>
	{/if}
    </div>
