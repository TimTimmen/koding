{ daisy
  expect
  withConvertedUser
  generateRandomEmail
  generateRandomString } = require '../../index'

JCredential = require '../../../lib/social/models/computeproviders/credential'


generateMetaData = (provider) ->

  meta = switch provider

    when 'google'
      projectId            : generateRandomString()
      privateKeyContent    : generateRandomString()
      clientSecretsContent : generateRandomString()

    when 'aws'
      region               : 'us-east-1'
      instance_type        : 't2.micro'
      storage_size         : 2

  return meta


withConvertedUserAndCredential = (options, callback) ->

  withConvertedUser options, (data) ->
    options.meta  ?= generateMetaData options.provider
    options.title ?= "test#{options.provider}#{generateRandomString()}"

    JCredential.create data.client, options, (err, credential) ->
      expect(err).to.not.exist
      data.credential = credential
      callback data


module.exports = {
  generateMetaData
  withConvertedUserAndCredential
}
