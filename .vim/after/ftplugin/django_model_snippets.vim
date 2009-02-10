if !exists('loaded_snippet') || &cp
    finish
endif

" Determine from vimrc if this is Django v1.0 or greater
" NOTE: If you are using Django 1.0 or greater, place the following in
" your vimrc file
"
" let django_version = 1
"
" If you are using a version of Django less than 1.0, simply do not
" place this line in your vimrc
if exists('django_version')
    if g:django_version == 1
        let s:django_version = 1
    else
        let s:django_version = 0
    endif
else
    let s:django_version = 0
endif

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
    endwhile
    return counter
endfunction

function! DjangoArgList(count)
    " This needs to be Python specific as print expects a
    " tuple and an empty tuple looks like this (,) so we'll need to make a
    " special case for it
    let st = g:snip_start_tag
    let et = g:snip_end_tag
    if a:count == 0
        return "()"
    else
        return '('.repeat(st.et.', ', a:count).')'
    endif
endfunction

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

if s:django_version
    let classmodbody = "def __unicode__(self):<CR>return self.".st.et
else
    let classmodbody = "class Admin:<CR>pass<CR><CR>def __str__(self):<CR>return \"".st."s".et."\" % ".st."s:DjangoArgList(Count(@z, '%[^%]'))".et
endif

if s:django_version
    let ml = "max_length"
else
    let ml = "maxlength"
endif

exec "Snippet mmodel class ".st.et."(models.Model):<CR>\"\"\"".st.et."\"\"\"<CR><CR>".st.et." = ".st.et."<CR><CR>".classmodbody."<CR>".st.et
exec "Snippet mauto models.AutoField(".st.et.")".st.et
exec "Snippet mbool models.BooleanField()".st.et
exec "Snippet mchar models.CharField(".ml."=".st."50".et.st.et.")".st.et
exec "Snippet mcsi models.CommaSeparatedIntegerField(".ml."=".st."50".et.st.et.")".st.et
exec "Snippet mdate models.DateField(".st.et.")".st.et
exec "Snippet mdatet models.DateTimeField(".st.et.")".st.et

if s:django_version
    exec "Snippet mdec models.DecimalField(max_digits=".st.et.", decimal_places=".st.et.")".st.et
endif

exec "Snippet memail models.EmailField(".st.et.")".st.et
exec "Snippet mfile models.FileField(upload_to=\"".st.et."\"".st.et.")".st.et
exec "Snippet mfilep models.FilePathField(path=\"".st.et."\"".st.et.")".st.et

if s:django_version
    let floatfopts = st.et
else
    let floatfopts = "max_digits=".st.et.", decimal_places=".st.et
endif
exec "Snippet mfloat models.FloatField(".floatfopts.")".st.et

exec "Snippet mimage models.ImageField(".st.et.")".st.et
exec "Snippet mint models.IntegerField(".st.et.")".st.et
exec "Snippet mipadd models.IPAddressField(".st.et.")".st.et
exec "Snippet mnull models.NullBooleanField()".st.et
exec "Snippet mphone models.PhoneNumberField(".st.et.")".st.et
exec "Snippet mpint models.PositiveIntegerField(".st.et.")".st.et
exec "Snippet mspint models.PositiveSmallIntegerField(".st.et.")".st.et
exec "Snippet mslug models.SlugField(".st.et.")".st.et
exec "Snippet msint models.SmallIntegerField(".st.et.")".st.et
exec "Snippet mtext models.TextField(".st.et.")".st.et
exec "Snippet mtime models.TimeField(".st.et.")".st.et
exec "Snippet murl models.URLField(verify_exists=".st."True".et.st.et.")".st.et
exec "Snippet muss models.USStateField(".st.et.")".st.et
exec "Snippet mxml models.XMLField(schema_path=\"".st.et."\"".st.et.")".st.et
exec "Snippet mfor models.ForeignKey(".st.et.")".st.et
exec "Snippet mm2o models.ForeignKey(".st.et.")".st.et
exec "Snippet mm2m models.ManyToManyField(".st.et.")".st.et
exec "Snippet mo2o models.OneToOneField(".st.et.")".st.et
exec "Snippet mman models.Manager()".st.et
