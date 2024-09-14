"""create table pilots

Revision ID: 469c3e97a602
Revises: 
Create Date: 2024-09-03 22:44:03.548798

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '469c3e97a602'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'pilots',
        sa.Column('id', sa.String, primary_key=True, index=True, nullable=False),
        sa.Column('firstname', sa.String, nullable=False),
        sa.Column('lastname', sa.String, nullable=False),
        sa.Column('phonenumber', sa.String, nullable=False),
        sa.Column('email', sa.String, nullable=False),
        sa.Column('active', sa.Boolean, nullable=False),
        sa.Column('acRegistrationValidTo', sa.Date, nullable=True),
        sa.Column('acPilotlicenseValidTo', sa.Date, nullable=True),
    )

def downgrade() -> None:
    op.drop_table('pilots')
