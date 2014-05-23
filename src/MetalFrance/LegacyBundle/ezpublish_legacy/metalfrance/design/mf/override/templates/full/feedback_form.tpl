{* Feedback form - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="attribute-header">
    <h1 class="mf-title mf-noicon">{$node.name|wash()}</h1>
</div>

<div class="content-view-full mf-body">
    <div class="class-feedback-form mf-top">


        {include name=Validation uri='design:content/collectedinfo_validation.tpl' validation=$validation collection_attributes=$collection_attributes}

        <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.description}
        </div>
        <form method="post" action={"content/action"|ezurl} class="mf-top">

		    <h3{if $node.data_map.sender_name.has_validation_error} class="message-error"{/if}>{$node.data_map.sender_name.contentclass_attribute.name} :</h3>
		    <div class="attribute-sender-name">
		            {attribute_view_gui attribute=$node.data_map.sender_name}
		    </div>
		
		    <h3{if $node.data_map.email.has_validation_error} class="message-error"{/if}>{$node.data_map.email.contentclass_attribute.name} :</h3>
		    <div class="attribute-email">
		            {attribute_view_gui attribute=$node.data_map.email}
		    </div>
		
		    <h3{if $node.data_map.subject.has_validation_error} class="message-error"{/if}>{$node.data_map.subject.contentclass_attribute.name} :</h3>
		    <div class="attribute-subject">
		            {attribute_view_gui attribute=$node.data_map.subject}
		    </div>
		
		    <h3{if $node.data_map.message.has_validation_error} class="message-error"{/if}>{$node.data_map.message.contentclass_attribute.name} :</h3>
		    <div class="attribute-message">
		            {attribute_view_gui attribute=$node.data_map.message}
		    </div>
		    
		    <h3{if $node.data_map.recaptcha.has_validation_error} class="message-error"{/if}>{$node.data_map.recaptcha.contentclass_attribute.name} :</h3>
		    <div class="attribute-recaptcha">
		            {attribute_edit_gui attribute=$node.data_map.recaptcha}
		    </div>
		
		    <div class="content-action">
		        <input type="submit" class="defaultbutton" name="ActionCollectInformation" value="{"Envoyer"|i18n( "extension/metalfrance" )}" />
		        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
		        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
		        <input type="hidden" name="ViewMode" value="full" />
    </div>
        </form>

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>