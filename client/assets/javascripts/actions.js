//Actions
import AppDispatcher from './app_dispatcher';
import Constants from './constants';
import Api from './api';

class Actions{

  constructor(restaurantId){
    this.restaurantId = restaurantId;
    this.watchInterval = setInterval(this.watch.bind(this), 1000);
  }

  addComment(params){
    Api.post(`/restaurants/${this.restaurantId}/comments`,{
      comment: params
    }).then( resp => {
        return resp.json();
    }).then( comment => {
      AppDispatcher.dispatch({
      actionType: Constants.ADD_COMMENT,
      comment: comment
      });
    });
  }

  upvoteComment(comment){
    Api.put(`/restaurants/${this.restaurantId}/comments/${comment.id}/upvote`).then( resp => {
        return resp.json()
    }).then( comment => {
      AppDispatcher.dispatch({
      actionType: Constants.UPVOTE_COMMENT,
      comment: comment
      });
    });
  }

  setComments(params){
    AppDispatcher.dispatch({
      actionType: Constants.SET_COMMENTS,
      comments: params
    });
  }

  watch(){
    Api.get(`/restaurants/${this.restaurantId}/comments`).then( resp => {
      return resp.json()
    }).then(comments => {
      this.setComments(comments);
    });
  }

}
export default Actions


