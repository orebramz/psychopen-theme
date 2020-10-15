<section class="card mb-3 default-card-layout">
    <div class="card-body">
        <div class="card-title">
            <h1>Volumes</h1>
        </div>
        <ul class="list-group list-group-flush">
            {assign var="tmp" value=""}
            {assign var="multiple" value=""}
            {assign var="count" value=0}
            {foreach from=$issues_full item="issue"}
                {if $issueViewType=='sortByYear'}
                    {if $issue->getVolume() != $tmp}
                        {assign var="tmp" value=$issue->getVolume()}
                        <li class="list-group-item {if $count>4}hidden hiddenElement{/if}">
                            {include file="frontend/objects/issue_summary_sidebar.tpl"}
                            {$count=$count+1}
                        </li>
                    {/if}
                {elseif $issueViewType=='sortByVolume'}
                    {if $issue->getYear() != $tmp}
                        {assign var="tmp" value=$issue->getYear()}
                        <li class="list-group-item {if $count>4}hidden hiddenElement{/if}">
                            {include file="frontend/objects/issue_summary_sidebar.tpl"}
                            {$count=$count+1}
                        </li>
                    {/if}
                {else}
                    <li class="list-group-item {if $count>4}hidden hiddenElement{/if}">
                        {include file="frontend/objects/issue_summary_sidebar.tpl"}
                        {$count=$count+1}
                    </li>
                {/if}
            {/foreach}
            {if $count>4}
                <li class="list-group-item">
                    <a href="#" id="sidebar_show_more">
                        <span><i class="fas fa-chevron-down"></i></span>
                        <span class="hidden"><i class="fas fa-chevron-up"></i></span>
                        <small class="text-dark ml-1" style="position: relative ;top: -2px;">Show all volumes</small>
                    </a>
                </li>
            {/if}
        </ul>
    </div>
</section>