{if $objectattribute.content.show_comments}
    {ezcss_require( 'comment.css' )}
    <div class="border-box">
    <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
    <div class="border-ml"><div class="border-mr"><div class="border-mc float-break">
    <div class="content-view-full ezcom-full">
    {if is_set( $error_message )}
        <div class="message-error">
            <p>
                {$error_message}
            </p>
        </div>
    {else}
        {include contentobject=$contentobject uri="design:comment/view_content.tpl"}
        <section class="mf-commentaires">
        {if $can_read}
            {def $current_user=fetch( 'user', 'current_user' )}
            {cache-block keys=array( $uri_string, 
                                     $current_user.role_id_list|implode( ',' ), 
                                     $current_user.limited_assignment_value_list|implode( ',' ) )
                         subtree_expiry=$contentobject.main_node_id}
                {def $total_count=fetch( 'comment', 'comment_count', 
                                         hash( 'contentobject_id', $contentobject.id,
                                               'language_id', $language_id,
                                               'status', 1 ) )}
                {def $total_page=$total_count|div($number_per_page)|ceil}
                {if $current_page|gt( $total_page )}
                    <div class="message-error">
                        <p>
                            {'Overflowed page number.'|i18n}
                        </p>
                    </div>
                {else}
                    {* Ajout MF *}
                    <p class="mf-backtocontent"><a href={$contentobject.main_node.url_alias|ezurl}>&laquo; {'Revenir à'|i18n( 'extension/metalfrance' )} "{$contentobject.name}"</a></p>
                    {* Comment list START *}   
                    {* Find out if the currently used role has a user based edit/delete policy *}
                    {def $self_policy=fetch( 'comment', 'self_policies', hash( 'contentobject', $contentobject, 'node', $node ) )}
                    {def $comments=fetch( 'comment', 
                                          'comment_list', 
                                          hash( 'contentobject_id', $contentobject.id, 
                                                'language_id',$language_id, 
                                                'sort_field', $sort_field, 
                                                'sort_order', $sort_order, 
                                                'offset', $offset, 
                                                'length', $length,
                                                'status', 1 ) )}
                    {if $comments|count|gt( 0 )}
                        <div class="ezcom-view-list">
                            <ul>
                            {for 0 to $comments|count|sub( 1 ) as $index}
                                {include comment=$comments.$index
                                         index=$index
                                         base_index=$current_page|sub( 1 )|mul( $number_per_page )
                                         contentobject=$contentobject
                                         language_code=$language_code
                                         can_self_edit=$self_policy.edit
                                         can_self_delete=$self_policy.delete
                                         uri="design:comment/view/comment_item.tpl"}
                            {/for}
                            </ul>
                        </div>
                    {else}
                        <div class="message-feedback">
                            <p>
                                {'There is no comment.'|i18n( 'ezcomments/comment/view' )}
                            </p>
                        </div>
                    {/if}
                    {* Comment list END *}
                    {* Comment page START *}
                    {include contentobject=$contentobject
                             language_id=$language_id
                             total_count=$total_count
                             total_page=$total_page
                             current_page=$current_page
                             uri="design:comment/view/page.tpl"}
                    {* Comment page END *}
                    {undef $comments $total_count $total_page}
                {/if}
            {/cache-block}
        {else}
            <div class="message-feedback">
                    <p>
                        {'You don\'t have access to view comment.'|i18n( 'ezcomments/comment/view' )}
                    </p>
            </div>
        {/if}
        {* Add comment form START *}
        {if $objectattribute.content.enable_comment}
            {if $can_add}
                {include uri="design:comment/add_comment.tpl" 
                         redirect_uri=concat( 'comment/view/', $contentobject.id ) 
                         contentobject_id=$contentobject.id 
                         language_id=$language_id}
            {else}
                    <div class="message-feedback">
                        <p>
                            {'You don\'t have access to post comment.'|i18n( 'ezcomments/comment/view' )}
                        </p>
                    </div>
            {/if}
        {/if}
        </section>
        {* Add comment form END *}
    {/if}
    </div>
    </div></div></div>
    <div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
    </div>
{/if}