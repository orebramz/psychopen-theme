<div class="row mb-2 article-details-cite">
    <div class="col-12">
        <ul class="list-group list-group-flush">
            {foreach $citeArray as $p}
                <li class="list-group-item">
                    {*<strong>{$p@key}:</strong>*}
                    <div>{$p}</div>
                </li>
            {/foreach}
        </ul>
    </div>
</div>