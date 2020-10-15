<section class="card mb-3 default-card-layout">
    <div class="card-body">
        {*<div class="card-title">
            <h1>{translate key="common.search"}</h1>
        </div>*}
        <ul class="list-group list-group-flush">
            <li class="list-group-item">
                <form role="search" method="post" action="{url page="search" op="search"}">
                    {csrf}
                    <div class="input-group">
                        <input class="form-control" name="query" value="{$searchQuery|escape}" type="text" aria-label="{translate|escape key="common.searchQuery"}"
                               placeholder="">
                        <div class="input-group-append">
                            <button type="submit" class="btn btn-secondary">{translate key="common.search"}</button>
                        </div>
                    </div>
                </form>
            </li>
        </ul>
    </div>
</section>