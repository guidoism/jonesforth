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

export { delay, wait, chunk, chunk as default }
