{ezcss_require( 'comment.css' )}
<div class="ezcom-add-result mf-body">
  {if is_set($error_message)}
    <div class="message-error">
        <p>
            {$error_message}
        </p>

        {if is_set( $validation_messages )}
            {foreach $validation_messages as $field => $message }
                <p><strong>{$field}:</strong><br /> {$message}</p>
            {/foreach}
        {/if}
        
        <p><a href="javascript:history.back();">&laquo; {'Back'|i18n( 'ezcomments/comment/view/action' )}</a></p>
    </div>
  {/if}
  {if and( is_set( $success ), $success|eq( 1 ) )}
    <div class="message-feedback">
        <p>
            {'Your comment has been posted.'|i18n( 'ezcomments/comment/add' )}
        </p>
        {if is_set( $success_message )}
        <p>
            {$success_message}
        </p>
        {/if}
        <p>&nbsp;</p>
        <p><a href={$redirect_uri|ezurl}>&laquo; {'Back'|i18n( 'ezcomments/comment/view/action' )}</a></p>
    </div>
  {/if}
</div>