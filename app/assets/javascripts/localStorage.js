if (!window.localStorage && /MSIE/.test(navigator.userAgent)) {
    if (!window.UserData) {
        window.UserData = function (file_name) {
            if (!file_name) file_name = "user_data_default";
            var dom = document.createElement('input');
            dom.type = "hidden";
            dom.addBehavior("#default#userData");
            document.body.appendChild(dom);
            dom.save(file_name);
            this.file_name = file_name;
            this.dom = dom;
            return this;
        };

        window.UserData.prototype = {
            setItem: function (k, v) {
                this.dom.setAttribute(k, v);
                this.dom.save(this.file_name);
            },
            getItem: function (k) {
                this.dom.load(this.file_name);
                return this.dom.getAttribute(k);
            },
            removeItem: function (k) {
                this.dom.removeAttribute(k);
                this.dom.save(this.file_name);
            }
        };
    }
    window.localStorage = new window.UserData("local_storage");
}