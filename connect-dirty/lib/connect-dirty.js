/*!
 * Connect - Dirty
 * Copyright(c) 2011 Jan Kolkmeier <jouzar@googlemail.com
 * MIT Licensed
 */

var Store = require('connect').session.Store;
var dirty = require('../../node-dirty/lib/dirty/index.js')

var DirtyStore = module.exports = function DirtyStore(options) {

  options = options || {dbname: 'sessions.db'},

  Store.call(this, options);
  this.client = dirty(options.dbname);
};

DirtyStore.prototype.__proto__ = Store.prototype;

DirtyStore.prototype.get = function (sid, cb) {
    data = this.client.get(sid);
    try {
        if (data) { 
            cb(null, JSON.parse(data));
        } else {
            return cb();
        }
    } catch (err) {
        cb(err);
    }
};

DirtyStore.prototype.set = function (sid, sess, cb) {
    try {
        this.client.set(sid, JSON.stringify(sess), function(){
            cb && cb(null, sess);
        });
    } catch (err) {
        cb && cb(err);
    }
}

DirtyStore.prototype.destroy = function (sid, cb) {
  this.client.remove(sid);
  cb()
};

DirtyStore.prototype.length = function (cb) {
  res = 0
  this.client.forEach(function(key, val) {
    res++;
  });
  cb(null, res);
};

DirtyStore.prototype.clear = function (cb) {
  this.client.forEach(function(key, val) {
    this.client.remove(key);
  });
  cb();
};
