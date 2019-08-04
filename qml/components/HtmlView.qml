/*
The MIT License (MIT)

Copyright (c) 2019 Slava Monich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0

SilicaWebView {
    property string htmlBody
    property int lastContentHeight

    interactive: false

    onWidthChanged: {
        if (width !== 0 && htmlBody.length) {
            loadHtml(htmlBody)
        }
    }

    onContentHeightChanged: {
        // Workaround for a weird problem with contentHeight getting too large
        // if we just use the obvious hight:contentHeight binding
        var h = Math.floor(contentHeight)
        if (h <= Theme.itemSizeMedium || h > lastContentHeight * 1.1) {
            height = h
        }
        lastContentHeight = contentHeight
    }

    onHtmlBodyChanged: {
        if (width !== 0) {
            lastContentHeight = 0
            loadHtml(htmlBody)
        }
    }
}
