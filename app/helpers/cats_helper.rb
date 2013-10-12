module CatsHelper

	def check_ownership(redirection_url)
		id = params[:id] || CatRentalRequest.find(params[:cat_rental_request_id]).cat_id
		cat = Cat.find(id)
		if cat.user_id != current_user.id
			redirect_to redirection_url, error: "You don't own the cat."
		end
	end

end
