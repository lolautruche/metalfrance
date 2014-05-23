{set-block scope=root variable=subject}{$collection.data_map.subject.data_text}{/set-block}
{set-block scope=root variable=email_reply_to}{$collection.data_map.email.data_text}{/set-block}
{set-block scope=root variable=content_type}{'text/html'}{/set-block}
{if and(is_set($object.data_map.recipient), $object.data_map.recipient.has_content)}
{set-block scope=root variable=email_receiver}{$object.data_map.recipient.content}{/set-block}
{/if}

{* Set this to redirect to another node
{set-block scope=root variable=redirect_to_node_id}2{/set-block}
*}

<h2>{"Un nouveau message de contact a été posté sur Metal France."|i18n( "extension/metalfrance/contact" )}</h2>
<h3>{"Vous pouvez directement répondre à cet e-mail pour contacter l'auteur du message."|i18n( "extension/metalfrance/contact" )}</h3>

{foreach $collection.attributes as $attribute}
	<p>
	  <strong>{$attribute.contentclass_attribute_name|wash} :</strong><br />
      {set-block variable=attributeContent}{attribute_result_gui view=info attribute=$attribute}{/set-block}
      {$attributeContent|trim()|simplify()|nl2br()}
    </p>

{/foreach}