///// ///// ///// ///// ///// ///// ///// ///// ///// /////
///// ///// ///// ///// ///// ///// ///// ///// ///// /////
///// ///// ///// ///// ///// ///// ///// ///// ///// /////
///// ///// ///// ///// ///// ///// ///// ///// ///// /////
// Move these guys to a util file

// Prints to string so we can debug on the console
function print_char(c, w) {
    let bw = chunk(c, 4).map(a => {
	if (a[0] > 0) return 'r'
	else if (a[1] > 0) return 'g'
	else if (a[2] > 0) return 'b'
	else if (a[3] > 0) return 'a'
    })
    return chunk(bw, w).map(a => a.map(j => j || '█').join('')).join('\n')
}

const delay = ms => new Promise(resolve => setTimeout(resolve, ms));
const wait = ms => new Promise((r, j)=>setTimeout(r, ms))
const chunk = (r,j) => r.reduce((a,b,i,g) => !(i % j) ? a.concat([g.slice(i,i+j)]) : a, []);

///////////////////////////////////////////////////////////////

const index_to_coordinates = i => [i & 127, i >> 7]

let canvas = new OffscreenCanvas(800, 480)
let ctx = canvas.getContext('2d')
let meta = {}
let font = {}

function greenify(img) {
    let [w, h] = [Math.max(...meta.chars.map(c => c.xadvance)), meta.common.lineHeight]
	 
    meta.chars.map((s, i) => {
	ctx.clearRect(0, 0, w, h)
	ctx.drawImage(img[s.page], s.x, s.y, s.width, s.height, s.xoffset, s.yoffset, s.width, s.height)
	let d = ctx.getImageData(0, 0, w, h)
	var buf = new ArrayBuffer(d.data.length);
	let datafrom = new Uint32Array(d.data.buffer)
	var buf8 = new Uint8ClampedArray(buf);
	var data = new Uint32Array(buf);
	datafrom.map((u, i) => data[i] = u >> 16 | 0xFF000000)
	d.data.set(buf8);
	font[s.id] = { glyph: d, meta: s }
    })

}

function fetchfont(done) {
    let loaded = () => {
	console.log('done')
    }
    let fetch_image = u => {
	return new Promise((resolve, reject) => {
	    let im = new Image()
	    im.onload = () => resolve(im)
	    im.onerror = reject
	    im.crossOrigin = "Anonymous"
	    im.src = u
	    return im
	})
    }
    
    let base = 'https://guidoism.github.io/jonesforth/experiments/'
    let url = base+'apl.fnt'
    fetch(url)
	.then(r => r.json())
	.then(r => {
	    meta = r
	    Promise.all(r.pages.map(i => fetch_image(base+i))).then(img => greenify(img)).then(done)
	})
}




export { fetchfont, font, meta, index_to_coordinates, greenify, delay, wait, chunk, chunk as default }
