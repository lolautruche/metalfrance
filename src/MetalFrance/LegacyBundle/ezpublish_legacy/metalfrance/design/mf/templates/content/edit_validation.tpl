     {section show=$validation.processed}
        {section show=or($validation.attributes,$validation.placement,$validation.custom_rules)}

          <div class="warning mf-top">
          {if or(and($validation.attributes,$validation.placement),$validation.custom_rules)}
            <h3>{"Validation failed"|i18n("design/standard/content/edit")}</h3>
          {else}
            {if $validation.attributes}
            <h3>{"Input did not validate"|i18n("design/standard/content/edit")}</h3>
            {else}
            <h3>{"Location did not validate"|i18n("design/standard/content/edit")}</h3>
            {/if}
          {/if}
          <ul>
          {section name=UnvalidatedPlacements loop=$validation.placement show=$validation.placement}
            <li>{$:item.text}</li>
          {/section}
          {section name=UnvalidatedAttributes loop=$validation.attributes show=$validation.attributes}
            <li>{$:item.name|wash}: {$:item.description}</li>
          {/section}
          {section name=UnvalidatedCustomRules loop=$validation.custom_rules show=$validation.custom_rules}
            <li>{$:item.text}</li>
          {/section}
          </ul>
          </div>

        {section-else}
	  {section show=$validation_log}
	  <div class="warning">
          <h3>{"Input was partially stored"|i18n("design/standard/content/edit")}</h3>
	      {section name=ValidationLog loop=$validation_log}
                  <h4>{$:item.name|wash}:</h4>
	          <ul>
	          {section name=LogMessage loop=$:item.description}
	              <li>{$:item}</li>
	          {/section}
                  </ul>
              {/section}
          </div>
	  {section-else}
          <div class="feedback">
          <h3>{"Input was stored successfully"|i18n("design/standard/content/edit")}</h3>
          </div>
	  {/section}
        {/section}
    {/section}
