module ApplicationHelper

	def full_title(subtitle = '')
		base = "Awesome gaming news Luna"
		if subtitle.empty?
			base
		else
			"#{subtitle} | #{base}"
		end
	end
end
