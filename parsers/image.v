module parsers

/**
 * Parse a Markdown image into HTML
 * 
 * @author Isaiah
 */
pub fn parse_image(text string) string {
	mut s := text
	mut aft := s
	mut brac := aft.index('![') or { -1 }
	for brac != -1 {
		aft = s
		if brac != -1 {
			mut endbrac := aft.index(']') or { -1} 
			if endbrac != -1 {
				mut title := aft.substr(brac+2, endbrac)
				mut startpr := aft.index('(') or {-1}
				mut endpr := aft.index(')') or {-1}
				if startpr != -1 && endpr != -1 {
					mut link := s.substr(startpr+1, endpr)
					mut start := s.substr(0, brac)
					mut end   := s.substr(endpr+1, s.len)
					mut a     := '<img src="' + link + '" alt="' + title +'">'
					s = start + a + end
				}
			}
		}
		aft = s
		brac = aft.index('![') or { -1 }
	}
	return s
}