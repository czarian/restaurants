import AppDispatcher from '../app_dispatcher';
import Constants from '../constants';
import {EventEmitter} from 'events';
class CommentStore extends EventEmitter {
  constructor() {
    super()
    this._comments = []

    AppDispatcher.register((payload) => {
      switch(payload.actionType){
        case Constants.SET_COMMENTS:
          this.setComments(payload.comments);
          this.emitChange()
        break;

        case Constants.UPVOTE_COMMENT:
          this.upvote(payload.comment);
          this.emitChange();
        break

        case Constants.ADD_COMMENT:
          this.addComment(payload.comment)
          this.emitChange()
        break;
        default:
          //NO-OP
      }
    });

  }

  upvote(comment){
    this._comments[comment.id].rank++;
  }

  addComment(comment){
    this._comments[comment.id || this._comments.length] = comment;
  }

  setComments(comments){
    comments.forEach(comment =>{
      this.addComment(comment)
    });
  }

  comments(parentId){
    return this._comments.filter( c => {return c && c.parent_id === parentId });
  }

  addChangeListner(callback){
    this.on(Constants.CHANGE_EVENT, callback);
  }

  removeChangeListner(callback){
    this.removeListener(Constants.CHANGE_EVENT, callback);
  }

  emitChange(){
    this.emit(Constants.CHANGE_EVENT);
  }
}

export default CommentStore
