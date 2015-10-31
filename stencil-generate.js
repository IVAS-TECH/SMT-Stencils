if (process.argv[2] === 'css')
    for (var i = 0; i < 9; ++i)
        console.log(css(cssClass(), i));

if (process.argv[2] === 'html') {
    var element = "<div class='c4'></div>";
    var res = [];
    for (i = 0; i < 4; ++i)
        element += node(element);
    while (element.indexOf('4') > 0)
        element = element.replace('4', '' + random(0, 9));
    console.log(element);
}

function node(e) {
    var s = "</div>"
    var n = "<div class='c4'></div>";
    var o = e;
    var pos = -1;
    while (random(0, 1)) {
        var next = random(pos, o.length);
        pos = o.indexOf(s, next / random(2, 5) - 1);
        o = [o.slice(0, pos), n, o.slice(pos)].join('');
        o = node(o);
    }
    return o;
}

function cssClass() {
    var bStyle = ['ridge', 'dotted', 'dashed'];
    var css = {};
    css.width = '' + random(40, 80) + '%;';
    css.height = '' + random(40, 80) + '%;';
    css.border = bStyle[(random(0, 30)) % 3] + ';';
    css.bw = '' + random(1, 3) + '%;';
    if (!random(0, 2))
        css.top = '' + random(10, 30) + '%;';
    if (!random(0, 2))
        css.bottom = '' + random(10, 30) + '%;';
    if (!random(0, 2))
        css.left = '' + random(10, 30) + '%;';
    if (!random(0, 2))
        css.right = '' + random(10, 30) + '%';
    return css;
}

function css(json, i) {
    s = '.c' + i + '{border:solid;position:absolute;border-color:white;';
    s += 'border-width:' + json.bw;
    s += 'width:' + json.width;
    s += 'height:' + json.height;
    s += 'border-style:' + json.border;
    if (json.top)
        s += 'top:' + json.top;
    if (json.bottom)
        s += 'bottom:' + json.bottom;
    if (json.left)
        s += 'left:' + json.left;
    if (json.right)
        s += 'right:' + json.right;
    s += '}'
    return s;
}

function random(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
