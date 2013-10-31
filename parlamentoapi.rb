require 'sinatra'
require 'yaml'
require 'haml'
require 'mongo'
require 'json'
require 'confstruct'

include Mongo

config = Confstruct::Configuration.new(
  YAML.load_file(
    File.expand_path(
      File.join(File.dirname(__FILE__), 'config.yaml')
    )
  )
)

configure do
  db = URI.parse(ENV['MONGOHQ_URL'])
  db_name = db.path.gsub(/^\//, '')

  conn = MongoClient.new(db.host, db.port)
  con.authenticate(db.user, db.password) unless (db.user.nil? || db.password.nil?)

  #conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db(db_name)
end

set :haml, :format => :html5

get '/' do
  haml :index
end

post '/senadores' do
  content_type :json
  options  = {}
  params.each_key do |key|
    options[key] = params[key].downcase
  end
 
  settings.mongo_db['senadores'].find(options).to_a.to_json
end

post '/diputados' do
  content_type :json
  options  = {}
  params.each_key do |key|
    options[key] = params[key].downcase
  end
 
  settings.mongo_db['diputados'].find(options).to_a.to_json
end

helpers do
  def object_id val
    BSON::ObjectId.from_string(val)
  end

  def document_by_id id
    id = object_id(id) if String === id
    settings.mongo_db['senadores']
    find_one(:_id => id).to_json
  end
end
