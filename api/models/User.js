'use strict';

var _ = require('lodash');
var crypto = require('crypto');

function genMD5Hash (seed) {
    seed = seed || new Date().toString()
    var md5 = crypto.createHash('md5');
    md5.update(seed);
    return md5.digest('hex');
}

/** @module User */
module.exports = {
  attributes: {
    username: {
      type: 'string',
      unique: true,
      index: true,
      notNull: true
    },
    email: {
      type: 'email',
      unique: true,
      index: true
    },
    passports: {
      collection: 'Passport',
      via: 'user'
    },
    authID: {
        type: 'string',
        defaultsTo: genMD5Hash()
    },

    getGravatarUrl: function getGravatarUrl() {
      return 'https://gravatar.com/avatar/' + genMD5Hash(this.email)
    },

    toJSON: function toJSON() {
      var user = this.toObject();
      delete user.password;
      user.gravatarUrl = this.getGravatarUrl();
      return user;
    }
  },

  beforeCreate: function beforeCreate(user, next) {
    if (_.isEmpty(user.username)) {
      user.username = user.email;
    }
    next();
  },

  /**
   * Register a new User with a passport
   */
  register: function register(user) {
    return new Promise(function (resolve, reject) {
      sails.services.passport.protocols.local.createUser(user, function (error, created) {
        if (error) return reject(error);

        resolve(created);
      });
    });
  }
};
