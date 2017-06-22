module TokenApiValidation
  def response_json(token)
    [
      token.cms_session.as_json(except: %i[id add_resource_callback_url cancel_url uid]),
      {
        'language' => token.material.language,
        'resource_url' => token.material.publisher_url,
        'resource_uid' => token.material.id,
        'bazaar_user_id' => token.cms_session.uid,
        'organization_name' => token.account.name,
        'organization_id' => token.account.id
      }
    ].inject(&:merge)
  end

  def validate_token
    @token = CmsToken.find_by!(token: params[:token])
    if @token.expired_at < Time.current
      token_timeout_error
    elsif @token.used
      token_used_error
    else
      @token.update_attributes!(used: true)
    end
  end
end
