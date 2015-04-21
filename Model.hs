module Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi
import Text.Markdown
import Yesod.Text.Markdown()
-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")

instance ToJSON BlogPost where 
  toJSON BlogPost {..} = object
     ["uid" .= blogPostUser,
      "title" .= blogPostTitle,
      "article" .= blogPostArticle
     ]
  
    
instance FromJSON BlogPost where
  parseJSON (Object v) = BlogPost
    <$> v .: "uid"
    <*> v .: "title"
    <*> v .: "article"
