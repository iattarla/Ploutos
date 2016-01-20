require 'rqrcode'

qrcode = RQRCode::QRCode.new("http://github.com/")

qrcode = RQRCode::QRCode.new("http://github.com/")
image = qrcode.as_png
svg = qrcode.as_svg
html = qrcode.as_html

image.save("qr.png")
svg.save("qr.svg")
html.save("qr.html")
