    <div class="block">
      <p><a href={"/comment/setting"|ezurl}>&raquo; {"My comment settings"|i18n("ezcomments/ezwebin/user/edit")}</a></p>
      {*<p><a href={"notification/settings"|ezurl}>{"My notification settings"|i18n("design/ezwebin/user/edit")}</a></p>*}
    </div>

    <div class="block">
      <label>{"Username"|i18n("design/ezwebin/user/edit")}</label><div class="labelbreak"></div>
      <p class="box">{$user.data_map.user_account.content.login|wash}</p>
    </div>
    
    <div class="block">
      <label>{"Email"|i18n("design/ezwebin/user/edit")}</label><div class="labelbreak"></div>
      <p class="box">{$user.data_map.user_account.content.email}</p>
    </div>
    
    <div class="block">
    {if or( $user.data_map.first_name.has_content, $user.data_map.last_name.content )}
      <label>{"Name"|i18n("design/ezwebin/user/edit")}</label><div class="labelbreak"></div>
      <p class="box">{$user.data_map.first_name.content|wash} {$user.data_map.last_name.content|wash}</p>
    {/if}
    </div>
    
    <div class="block">
      <label>{"Avatar"|i18n( "extension/metalfrance/user" )} :</label><div class="labelbreak"></div>
    {if $user.data_map.local_avatar.has_content}
      <p class="box"><img src={$user.data_map.local_avatar.content.medium.url|ezroot} alt="{"Avatar de %user"|i18n( 'extension/metalfrance/user',, hash( '%user', $user.name ) )}"/></p>
    {else}
      <p>{"Pas d'avatar"|i18n( 'extension/metalfrance/user' )}</p>
    {/if}
    </div>
    
    <div class="buttonblock">
	    <input class="button" type="submit" name="EditButton" value="{'Edit profile'|i18n('design/ezwebin/user/edit')}" />
	    <input class="button" type="submit" name="ChangePasswordButton" value="{'Change password'|i18n('design/ezwebin/user/edit')}" />
    </div>