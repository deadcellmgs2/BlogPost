module Handler.BlogPost where

import Import
import Yesod.Form.Bootstrap3 
import Yesod.Text.Markdown (markdownField) 


blogPostForm:: UserId -> Maybe BlogPost -> AForm Handler BlogPost
blogPostForm uid mBlogPost= BlogPost
               <$> pure uid
               <*> areq textField (bfs MsgTitle) (blogPostTitle <$> mBlogPost)
               <*> areq markdownField (bfs MsgArticle) (blogPostArticle <$> mBlogPost)  
               
getBlogPostNewR :: Handler Html
getBlogPostNewR = do
  uid <- requireAuthId
  (widget,encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ blogPostForm uid Nothing
  defaultLayout $ do
    $(widgetFile "blog/new")
    
postBlogPostNewR :: Handler Html
postBlogPostNewR = do
  uid <- requireAuthId
  ((result,widget),encoding) <- runFormPost $
                                renderBootstrap3 BootstrapBasicForm $ blogPostForm uid Nothing
  case result of
    FormSuccess blogPost -> do
                            bid <- runDB $ insert blogPost
                            redirect (BlogPostR bid)
    _ -> defaultLayout $ do
      $(widgetFile "blog/new")


putBlogPostNewJsonR :: Handler Value
putBlogPostNewJsonR = do
  blogPost <- parseJsonBody_ :: Handler BlogPost
  bId <- runDB $ insert blogPost
  returnJson $ bId

getBlogPostNewJsonR :: Handler Html
getBlogPostNewJsonR = do
  defaultLayout $ do
    $(widgetFile "blog/newJson")




getBlogPostR :: BlogPostId -> Handler TypedContent
getBlogPostR bpid = do
  blogPost <- runDB $ get404 bpid
  selectRep $ do
    provideRep $ defaultLayout $ do
      $(widgetFile "blog/details")
    provideJson $ blogPost
    
deleteBlogPostR :: BlogPostId -> Handler Html
deleteBlogPostR bpid = do
  uid <- requireAuthId
  runDB $ delete bpid
  defaultLayout $ do
    [whamlet| |]


getBlogPostUpdateR :: BlogPostId -> Handler Html
getBlogPostUpdateR blogPostId = do
  uid <- requireAuthId
  blogPost <- runDB  $  get404 blogPostId
  (widget,encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ blogPostForm uid (Just blogPost)
  defaultLayout $ do
    $(widgetFile "blog/edit")
    
postBlogPostUpdateR :: BlogPostId -> Handler Html
postBlogPostUpdateR blogPostId =  do
  uid <- requireAuthId
  blogPost <- runDB $ get404 blogPostId
  ((result,widget),encoding) <- runFormPost $
                                renderBootstrap3 BootstrapBasicForm $ blogPostForm uid (Just blogPost)
  case result of
    FormSuccess blogPost -> do
                            runDB $ replace blogPostId blogPost
                            redirect (BlogPostR blogPostId)
    _ -> defaultLayout $ do
      $(widgetFile "blog/new")
