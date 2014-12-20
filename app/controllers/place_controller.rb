class PlaceController
  def post
    render :status => :created, :location => 'http://location:3000/place/'
    return
  end
end