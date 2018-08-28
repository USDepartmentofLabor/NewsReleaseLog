module Importers
  class UsersDataSet
    def headers
      [
        "OPAID",
        "RegionID",
        "AgencyID",
        "OPANumIssueDate",
        "ReceivedDate",
        "ReleaseDate",
        "OPASeqnum2",
        "UserInitial",
        "Title",
        "TitleURL",
        "TitleFile",
        "OPASeqnum2",
        "FIELD13",
        "FIELD14"
      ]


    end

    def row_mapping
      [
        :name,
        :code,
        :description,
        :status,
        :abbr,
        :name,
        :received_date,
        :release_date,
        :title,
        :news_release_number,
        :aasm_state,
        :opa_id,
        :document,
        :email,
        :encrypted_password,
        :first_name,
        :last_name,
        :reset_password_token,
        :reset_password_sent_at,
        :remember_created_at,
        :sign_in_count,
        :current_sign_in_at,
        :last_sign_in_at,
        :current_sign_in_ip,
        :last_sign_in_ip
      ]
    end

    include ::Importers::RowSet

  end
end