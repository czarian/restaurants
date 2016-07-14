import Comment from './comment';
import React from 'react';
class CommentList extends React.Component{

  static get contextTypes(){
    return {
      store: React.PropTypes.object.isRequired
    }
  }

  componentDidMount(){
    this.context.store.addChangeListner(this._onChange.bind(this));
  }

  componentWillUnmount(){
    this.context.store.removeChangeListner(this._onChange.bind(this));
  }

  render(){
    return <ul>
        {this.context.store.comments(this.props.parent_id ).map((comment, i) => {
           return <Comment key={i} {...comment} />;
        })}
      </ul>;
  }

  _onChange(){
    this.forceUpdate();
  }

}
export default CommentList;
