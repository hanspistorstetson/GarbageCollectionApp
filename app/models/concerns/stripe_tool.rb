module StripeTool


    def self.create_customer
    end

    def self.create_charge
    end

    def self.create_membership(email: email, stripeToken: stripe_token, plan: plan)

        Stripe::Customer.create(
            email:          email,
            stripe_token:   stripe_token,
            plan:           plan
            )
    end

end